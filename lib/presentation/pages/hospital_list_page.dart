import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/hospital_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/hospital_event.dart'; 
import 'package:flutter_application_1/presentation/bloc/hospital_state.dart';
import 'hospital_detail_page.dart';

class HospitalListPage extends StatefulWidget {
  const HospitalListPage({Key? key}) : super(key: key);

  @override
  State<HospitalListPage> createState() => _HospitalListPageState();
}

class _HospitalListPageState extends State<HospitalListPage> {
  @override
  void initState() {
    super.initState();
    context.read<HospitalBloc>().add(FetchHospitals()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital List'),
      ),
      body: BlocBuilder<HospitalBloc, HospitalState>(
        builder: (context, state) {
          if (state is HospitalLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HospitalLoaded) {
            if (state.hospitals.isNotEmpty) {
              return ListView.builder(
                itemCount: state.hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = state.hospitals[index];
                  return ListTile(
                    title: Text(hospital.name),
                    subtitle: Text(hospital.address),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HospitalDetailPage(hospital: hospital),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('No hospitals'));
            }
          } else if (state is HospitalError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No hospitals'));
          }
        },
      ),
    );
  }
}