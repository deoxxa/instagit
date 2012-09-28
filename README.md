instagit
========

No-frills git/ssh gateway

Overview
--------

Maintaining a git hosting configuration in a small team is often more of a
burden than it's worth. If you're not using any of the permissions or other
advanced functions of a fully featured hosting platform, it tends to just get in
the way.

Enter instagit. instagit tries to solve this problem by doing away with most of
the features you'll usually find in a git/ssh gateway program. There's no
permissions, no granular security other than what SSH provides, no notion of
users, no built in management, not even any repository management (new repos are
created the first time you try to push to them).

Everything in instagit is designed to be low friction and *very* easy to get
started with. Installation is as simple as dropping `instagit.sh` and
(optionally) `.instagit.rc` into the home directory of a user and setting up
your ssh keys.

It's encouraged to modify `instagit.sh` to suit your needs. I'm personally using
it as the basis of a deployment system and for regular old code hosting.

Installation
------------

You can do things manually (it's pretty simple) or you can use the included
`install-as-root.sh` script to perform a rather rudimentary installation for
you.

```
root@remote:~/instagit# ./install-as-root.sh gits /home/gits
>>> adduser --system --shell /bin/sh --home /home/gits --disabled-password gits
<<< Adding system user `gits' (UID 115) ...
<<< Adding new user `gits' (UID 115) with group `nogroup' ...
<<< Creating home directory `/home/gits' ...
>>> cp -v -a /root/instagit/bin/instagit.sh /home/gits/instagit.sh
<<< `/root/instagit/bin/instagit.sh' -> `/home/gits/instagit.sh'
>>> chmod -v 755 /home/gits/instagit.sh
<<< mode of `/home/gits/instagit.sh' retained as 0755 (rwxr-xr-x)
>>> cp -v -a /root/instagit/config/instagit.rc.example /home/gits/.instagit.rc
<<< `/root/instagit/config/instagit.rc.example' -> `/home/gits/.instagit.rc'
>>> chmod -v 644 /home/gits/.instagit.rc
<<< mode of `/home/gits/.instagit.rc' retained as 0644 (rw-r--r--)
>>> mkdir -v /home/gits/gits
<<< mkdir: created directory `/home/gits/gits'
>>> chown -v gits /home/gits/gits
<<< changed ownership of `/home/gits/gits' to gits
>>> chmod -v 700 /home/gits/gits
<<< mode of `/home/gits/gits' changed to 0700 (rwx------)
>>> mkdir -v /home/gits/.ssh
<<< mkdir: created directory `/home/gits/.ssh'
>>> chown -v gits /home/gits/.ssh
<<< changed ownership of `/home/gits/.ssh' to gits
>>> chmod -v 700 /home/gits/.ssh
<<< mode of `/home/gits/.ssh' changed to 0700 (rwx------)

Now that this is done, you're going to need to add a user to the /home/gits/.ssh/authorized_keys file with the correct options. You'll want it to look like this:

command="/home/gits/instagit.sh" ssh-rsa <KEY_DATA_OMITTED>

After that, you should be good to go. Feel free to open an issue at https://github.com/deoxxa/instagit/issues if there are any problems.

Good luck!
root@remote:~/instagit#
```

Usage
-----

After installation, you should just be able to start pushing to and subsequently
pulling from repositories like so:

```
user@local:~/work/seriousbusiness/instagit$ git push --mirror gits@remote:instagit.git
Initialized empty Git repository in /home/gits/gits/instagit.git/
Counting objects: 28, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (22/22), done.
Writing objects: 100% (28/28), 3.62 KiB, done.
Total 28 (delta 6), reused 7 (delta 0)
To gits@remote:instagit.git
 * [new branch]      master -> master
 * [new branch]      origin/master -> origin/master
user@local:~/work/seriousbusiness/instagit$
```

License
-------

3-clause BSD. A copy is included with the source.

Contact
-------

* GitHub ([deoxxa](http://github.com/deoxxa))
* Twitter ([@deoxxa](http://twitter.com/deoxxa))
* ADN ([@deoxxa](https://alpha.app.net/deoxxa))
* Email ([deoxxa@fknsrs.biz](mailto:deoxxa@fknsrs.biz))
