# Linux Architecture Notes

## Core Components of Linux

* **Hardware**: Physical components such as CPU, RAM, Disk and Network devices.
* **Kernel**: Core of Linux that manages hardware, memory, processes and system resources.
* **User Space**: Area where users and applications run.
* **Shell**: Command-line interface used to communicate with the kernel.
* **systemd**: First process (PID 1) responsible for managing services and system startup.

---

# Processes in Linux

A process is a running instance of a program.

Examples:

* nginx
* sshd
* docker
* python

Each process has a unique Process ID (PID).

Common commands:

```bash
ps aux
top
```

## Process States

* **Running (R)**: Process is actively using CPU.
* **Sleeping (S)**: Process is waiting for an event or resource.
* **Stopped (T)**: Process execution is paused.
* **Zombie (Z)**: Process has completed execution but still exists in the process table.

---

# Understanding systemd

systemd is the init system used by modern Linux distributions.

Responsibilities:

* Starts services during boot
* Manages system services
* Handles service failures
* Controls startup sequence

Example:

```bash
systemctl status sshd
```

---

# 5 Commands Used Daily

* **ps** : View running processes.
* **top** : Monitor system resources in real time.
* **systemctl** : Manage services.
* **df -h** : Check disk usage.
* **free -h** : Check memory usage.
