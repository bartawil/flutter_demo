// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notification_repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  // Create an instance of the notification repository
  // ignore: prefer_final_fields
  NotificationRepository _notificationRepository;

  NotificationBloc({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(NotificationInitial()) {
    // Define BLoC event handlers using 'on' method
    on<CreateNotification>((event, emit) async {
      emit(NotificationLoading());
      try {
        // Attempt to create a notification using the repository
        MyNotification notification = await _notificationRepository
            .createNotification(event.notification);
        emit(NotificationSuccess(notification));
      } catch (e) {
        emit(NotificationFailure());
      }
    });
    on<GetNotificationsSize>((event, emit) async {
      emit(GetNotificationsSizeLoading());
      try {
        // Get the size of the notification collection from the repository
        double size =
            await _notificationRepository.getNotificationCollectionSize();
        emit(GetNotificationsSizeSuccess(size));
      } catch (e) {
        emit(GetNotificationsSizeFailure());
      }
    });
    on<GetNotificationsList>((event, emit) async {
      emit(GetNotificationsListLoading());
      try {
        log("GetNotificationsList", name: "NotificationBloc");
        // Retrieve the list of notifications from the repository
        List<MyNotification> notificationList =
            await _notificationRepository.getNotificationsList();
        log(notificationList.length.toString(), name: "NotificationBloc");

        emit(GetNotificationsListSuccess(notificationList));
      } catch (e) {
        log("Error in GetNotificationsList event: $e",
            name: "NotificationBloc"); // Log the error message
        emit(GetNotificationsListFailure());
      }
    });
    on<DeleteNotification>((event, emit) async {
      emit(DeleteNotificationLoading());
      try {
        // Delete a notification by its ID using the repository
        List<MyNotification> notificationList =
            await _notificationRepository.deleteNotification(event.id);
        emit(DeleteNotificationSuccess(notificationList));
      } catch (e) {
        emit(DeleteNotificationFailure());
      }
    });
  }
}
