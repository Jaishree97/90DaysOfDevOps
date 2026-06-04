# SSH Access Notes

This document contains notes from configuring SSH access for the `berlin` user on an EC2 instance.

---

## Objective

Allow the `berlin` user to log in using the same EC2 key pair (`miya.pem`) used by the default `ubuntu` user.

---

## Commands Used

Create SSH directory:

```bash
sudo mkdir -p /home/berlin/.ssh
```

Copy authorized keys:

```bash
sudo cp /home/ubuntu/.ssh/authorized_keys /home/berlin/.ssh/
```

Change ownership:

```bash
sudo chown -R berlin:berlin /home/berlin/.ssh
```

Set permissions:

```bash
sudo chmod 700 /home/berlin/.ssh
sudo chmod 600 /home/berlin/.ssh/authorized_keys
```

---

## Login Test

```bash
ssh -i "miya.pem" berlin@<public-ip>
```

Verification:

```bash
whoami
pwd
```

Output:

```text
berlin
/home/berlin
```

---

## Notes

* New Linux users cannot use SSH automatically.
* SSH requires an `authorized_keys` file inside the user's `.ssh` directory.
* Proper ownership and permissions are required for SSH authentication.
* Reusing the existing EC2 public key allowed the `berlin` user to log in successfully.

---

## Learning

SSH key-based authentication works by matching the private key (`miya.pem`) with the public key stored in `authorized_keys`. Once configured correctly, custom users can securely access the server without passwords.
