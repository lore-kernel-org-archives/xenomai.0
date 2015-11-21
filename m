Message-ID: <BLU436-SMTP5068DD4CFCAD34C1CC29DDF0190@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Fri, 20 Nov 2015 21:53:42 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] registry
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

When a skin (lets say vxworks for example) does a
registry_add_dir("/vxworks"), where this directory gets created?

I can see the registry as follow:
/var/run/xenomai/root/
/var/run/xenomai/system/heaps
/var/run/xenomai/system/threads
/var/run/xenomai/system/version

This is how I started the registry:
sudo ./sysregd --linger --daemonize --anon --root=/var/run/xenomai

so I was expecting to be able to find a directory as follow:
/var/run/xenomai/anon/<pid>/vxworks

>From my test app, I have tried to find the directory in those locations
with no luck:
/var/run/xenomai/<pid>/vxworks
/var/run/xenomai/vxworks

Now I think I am missing a setup somewhere.

Thanks for any pointers,
Regards,
-Mathieu


