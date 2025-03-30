import 'package:flutter/material.dart';
import 'package:clinic/diagnosis_input_screen.dart';

class DoctorAssignmentScreen extends StatefulWidget {
  final Patient patient;

  const DoctorAssignmentScreen({super.key, required this.patient});

  @override
  _DoctorAssignmentScreenState createState() => _DoctorAssignmentScreenState();
}

class _DoctorAssignmentScreenState extends State<DoctorAssignmentScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Doctor> _filteredDoctors = [];
  Doctor? _selectedDoctor;

  @override
  void initState() {
    super.initState();
    _filteredDoctors = dummyDoctors;
  }

  void _filterDoctors(String query) {
    setState(() {
      _filteredDoctors = dummyDoctors.where((doctor) {
        final nameLower = doctor.name.toLowerCase();
        final specialtyLower = doctor.specialty.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower) ||
            specialtyLower.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Doctor'),
        backgroundColor: const Color(0xFF2A5C82),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterDoctors,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDoctors.length,
              itemBuilder: (context, index) =>
                  _buildDoctorCard(_filteredDoctors[index]),
            ),
          ),
          _buildAssignmentButton(),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    final isSelected = _selectedDoctor == doctor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? const Color(0xFF34A853) : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF2A5C82),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(doctor.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(doctor.specialty),
            Text('Available: ${doctor.availability}'),
          ],
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Color(0xFF34A853))
            : null,
        onTap: () => setState(() => _selectedDoctor = doctor),
      ),
    );
  }

  Widget _buildAssignmentButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.medical_services),
        label: Text(_selectedDoctor == null
            ? 'Select a Doctor'
            : 'Assign Dr. ${_selectedDoctor!.name} to ${widget.patient.name}'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF34A853),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _selectedDoctor != null ? _confirmAssignment : null,
      ),
    );
  }

  void _confirmAssignment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Assignment'),
        content: Text(
            'Assign Dr. ${_selectedDoctor!.name} to ${widget.patient.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A5C82)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, _selectedDoctor);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Doctor Model
class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String availability;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.availability,
  });
}

// Dummy Doctors Data
List<Doctor> dummyDoctors = [
  Doctor(
    id: 'D1',
    name: 'Dr. Anjali Deshpande',
    specialty: 'Pulmonology',
    availability: 'Mon-Fri, 9AM-5PM',
  ),
  Doctor(
    id: 'D2',
    name: 'Dr. Rajesh Verma',
    specialty: 'Infectious Diseases',
    availability: '24/7 Emergency',
  ),
  Doctor(
    id: 'D3',
    name: 'Dr. Priya Singh',
    specialty: 'General Medicine',
    availability: 'Telemedicine Only',
  ),
];
