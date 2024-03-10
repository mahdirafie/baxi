import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class IAPIDataSource {
  Future<void> signUpUser();
  Future<void> updateEmail();
  Future<void> createAddress();
  Future<void> signUpDriver();
  Future<void> createDriverCertificate();
  Future<void> createDisability();
  Future<void> createViolation();
  Future<void> createBaxiBar();
  Future<void> createBaxiBox();
  Future<void> createBaxi();
  Future<void> createDestination();
  Future<void> createEmployee();
  Future<void> createDriverWallet();
  Future<void> createUserWallet();
  Future<void> listOfTransactions();
  Future<void> listOfDriverTransactions();
  Future<void> createMotorcycle();
  Future<void> createTruck();
  Future<void> createCar();
  Future<void> createLevel();
  Future<void> createPoliceCertificate();
  Future<void> policeCertificateFinalApproval();
  Future<void> certificateApproval();
  Future<void> certificateDefect();
  Future<void> createTravelScore();
  Future<void> createTravelViolation();
  Future<void> createTravelLocation();
}

class APIRemoteDataSource implements IAPIDataSource {
  final Dio httpClient;

  APIRemoteDataSource({required this.httpClient});

  @override
  Future<void> certificateApproval() async {
    final response = await httpClient.post('https://localhost:8080/u/signup');
  }

  @override
  Future<void> certificateDefect() async {
    final response = await httpClient.post('https://localhost:8080/u/email');
  }

  @override
  Future<void> createAddress() async {
    final response = await httpClient.post('https://localhost:8080/a/create');
  }

  @override
  Future<void> createBaxi() async {
    final response = await httpClient.post('https://localhost:8080/d/signup');
  }

  @override
  Future<void> createBaxiBar() async {
    final response = await httpClient.post('https://localhost:8080/c/create');
  }

  @override
  Future<void> createBaxiBox() async {
    final response = await httpClient.post('https://localhost:8080/d/disability');
  }

  @override
  Future<void> createCar() async {
    final response = await httpClient.post('https://localhost:8080/v/create');
  }

  @override
  Future<void> createDestination() async {
    final response = await httpClient.post('https://localhost:8080/b/bar');
  }

  @override
  Future<void> createDisability() async {
    final response = await httpClient.post('https://localhost:8080/b/box');
  }

  @override
  Future<void> createDriverCertificate() async {
    final response = await httpClient.post('https://localhost:8080/b/baxi');
  }

  @override
  Future<void> createDriverWallet() async {
    final response = await httpClient.post('https://localhost:8080/t/req');
  }

  @override
  Future<void> createEmployee() async {
    final response = await httpClient.post('https://localhost:8080/e/signup');
  }

  @override
  Future<void> createLevel() async {
    final response = await httpClient.post('https://localhost:8080/d/wallet/create');
  }

  @override
  Future<void> createMotorcycle() async {
    final response = await httpClient.post('https://localhost:8080/u/wallet/create');
  }

  @override
  Future<void> createPoliceCertificate() async {
    final response = await httpClient.post('https://localhost:8080/l/u/create');
  }

  @override
  Future<void> createTravelLocation() async {
    final response = await httpClient.post('https://localhost:8080/l/d/create');
  }

  @override
  Future<void> createTravelScore() async {
    final response = await httpClient.post('https://localhost:8080/d/motorcycle');
  }

  @override
  Future<void> createTravelViolation() async {
    final response = await httpClient.post('https://localhost:8080/d/certificate');
  }

  @override
  Future<void> createTruck() async {
    final response = await httpClient.post('https://localhost:8080/d/truck');
  }

  @override
  Future<void> createUserWallet() async {
    final response = await httpClient.post('https://localhost:8080/d/car');
  }

  @override
  Future<void> createViolation() async {
    final response = await httpClient.post('https://localhost:8080/d/level');
  }

  @override
  Future<void> listOfDriverTransactions() async {
    final response = await httpClient.post('https://localhost:8080/d/police_certificate');
  }

  @override
  Future<void> listOfTransactions() async {
    final response = await httpClient.post('https://localhost:8080/d/update/police_certificate/approval');
  }

  @override
  Future<void> policeCertificateFinalApproval() async {
    final response = await httpClient.post('https://localhost:8080/d/update/certificate/approval');
  }

  @override
  Future<void> signUpDriver() async {
    final response = await httpClient.post('https://localhost:8080/d/create/defect');
  }

  @override
  Future<void> signUpUser() async {
    final response = await httpClient.post('https://localhost:8080/t/create/score');
  }

  @override
  Future<void> updateEmail() async {
    final response = await httpClient.post('https://localhost:8080/t/create/violation');
  }
}
