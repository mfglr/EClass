import 'package:flutter/material.dart';

@immutable
class SolutionUserVoteState{
  final int id;
  final DateTime createdAt;
  final int solutionId;
  final int appUserId;

  const SolutionUserVoteState({
    required this.id,
    required this.createdAt,
    required this.solutionId,
    required this.appUserId
  });
}