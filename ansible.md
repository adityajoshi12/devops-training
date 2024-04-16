# Core Architecture

* **Control Node:** The machine where Ansible is installed and from which you manage your infrastructure.  
* **Managed Nodes:** The servers, network devices, or other infrastructure components that you manage with Ansible.
* **Inventory:** A file or collection of files defining the managed nodes and their groupings.
* **Modules:** Reusable, standalone scripts that perform specific tasks on managed nodes.
* **Playbooks:** YAML files that orchestrate tasks, define configurations, and automate processes using modules.
* **Connection Plugins:** Enable communication with managed nodes using protocols like SSH.

**Essential Components:**

* **Modules:**
    * Building blocks of automation.
    * Perform specific tasks like installing packages, managing files, starting services.
    * Numerous built-in modules available, and you can also write your own. 
    * Examples: `apt`, `yum`, `service`, `file`, `copy`, `template`. 
* **Playbooks:**
    * Define automation workflows using YAML. 
    * Group tasks into plays and apply them to specific hosts or groups. 
    * Use variables and conditionals for flexibility.
    * Example structure:
    
```
    - hosts: webservers
      become: true
      tasks:
        - name: Install Apache
          apt: name=apache2 state=present
        - name: Start Apache
          service: name=apache2 state=started
```
* **Inventory:**
    * Defines managed nodes and groups.
    * Can be a simple text file or use dynamic inventory sources.
    * Example:
    
```
[webservers]
    web1.example.com
    web2.example.com

    [dbservers]
    db1.example.com
```
﻿
* **Variables:**
    * Store reusable values like usernames, passwords, or application names.
    * Improve playbook readability and maintainability. 
    * Defined in various places like inventory, playbooks, or external files.
