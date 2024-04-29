# Assignment on Ansible

**Web Server Setup:** 
* Write a playbook to install and configure a web server (Apache/Nginx) on a managed node. 
* Include tasks to:
* Update the package manager cache.
* Install the web server package.
* Start and enable the web server service.
* Copy a basic HTML file to the document root directory.
* Optionally, configure firewall rules to allow HTTP/HTTPS traffic. 
<details>
        <summary>Solution</summary>

```yaml
---
- hosts: webservers
  become: true
  tasks:
    - name: Update apt cache
      apt: update_cache=yes

    - name: Install nginx
      apt: name=nginx state=present

    - name: Start and enable nginx
      service: name=nginx state=started enabled=yes

    - name: Copy index.html
      copy:
        src: index.html
        dest: /var/www/html/index.html
        owner: root
        group: root
        mode: 0644

    - name: Allow HTTP traffic
      ufw:
        rule: allow
        port: 80
        proto: tcp

    # Uncomment for HTTPS configuration
    # - name: Allow HTTPS traffic
    #   ufw:
    #     rule: allow
    #     port: 443
    #     proto: tcp
```

**Explanation:**

* This playbook targets the "webservers" group.
* It uses `become: true` to run tasks with root privileges.
* Tasks update the package cache, install Nginx, start and enable the service.
* It copies a local `index.html` file to the document root. 
* Finally, it opens port 80 for HTTP access (adjust for HTTPS if needed).
</details>




**User Management:**
* Write a playbook to create multiple users on a managed node. 
* Use variables to define user information like username, password, groups, etc.
* Include tasks to:
    * Add users.
    * Set passwords.
    * Assign users to specific groups.
    * Optionally, create home directories and set permissions.
<details>
<summary>Solution</summary>

```yaml
---
- hosts: all
  become: true
  vars:
    users:
      - username: john
        password: "password123"
        groups: "sudo,developers"
      - username: jane
        password: "securepassword"
        groups: "developers"

  tasks:
    - name: Create users
      user:
        name: "{{ item.username }}"
        password: "{{ item.password | crypt }}"
        groups: "{{ item.groups }}"
        shell: /bin/bash
        createhome: yes
      loop: "{{ users }}"
```

**Explanation:**

* This playbook targets all hosts.
* The `users` variable defines a list of user dictionaries, each with username, password, and groups.
* The loop iterates through the `users` list, creating users with the specified attributes, setting passwords, and assigning groups.

</details>





**Database Deployment:**
*   Create a playbook to install and configure a database server (MySQL or PostgreSQL) on a managed node. 
*   Include tasks to create databases and users with appropriate privileges.
*   Bonus: Implement database backups and secure the database server.


<details>
<summary>Solution</summary>

```yaml
---
- hosts: database_servers
  become: true
  tasks:
    # Install PostgreSQL and required packages
    - name: Install PostgreSQL server
      apt:
        name: postgresql
        state: present
      
    # Start and enable PostgreSQL service
    - name: Start and enable PostgreSQL service
      service:
        name: postgresql
        state: started
        enabled: yes
      
    # Create database
    # more details about module - https://docs.ansible.com/ansible/latest/collections/community/postgresql/postgresql_db_module.html
    - name: Create database
      postgresql_db:
        name: my_database
        state: present

    # Create user
    - name: Create database user
      postgresql_user:
        name: my_user
        password: my_secure_password
        priv: my_database:ALL
        state: present
      
    # Bonus: Implement database backups (example using pg_dump)
    - name: Create backup directory
      file:
        path: /backups/database
        state: directory
        
    - name: Backup database
      postgresql_db:
        name: my_database
        state: dump
        target: /backups/database/my_database_backup.sql

    # Bonus: Secure the database server (example using firewall)
    - name: Allow PostgreSQL connections
      ufw:
        rule: allow
        port: 5432
        proto: tcp
```
</details>
