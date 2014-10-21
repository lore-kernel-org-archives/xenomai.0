From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Tue, 21 Oct 2014 21:48:55 +0000
Message-ID: <D06C3EF5.19661%shartmann@cnt.canon.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Troubleshooting general protection faults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi All,

I am having a really strange and hard to troubleshoot problem on multiple s=
ystems and hope that someone here could maybe throw some tips my way.  I am=
 running Xenomai 2.6.4 on linux 3.4.6, amd64.  I am also using the Etherlab=
s ethercat stack out of their stable-1.5 branch.   From time to time, the s=
ystem suddenly goes into a state where most programs, including bash, will =
immediately crash, which means we notice this when we can no longer ssh int=
o the machine - ssh still answers, but bash crashes, so it hangs up immedia=
tely.  Even sudo will crash.  The frequency of this problem has been anywhe=
re between 24 hours and 30 days.  Most of the time, our application continu=
es to run, although I have seen times when it has segfaulted when this issu=
e occurs.  I have found the following messages in dmesg kernel ring buffer =
when attempting to run bash(via ssh) and sudo:

[453435.329099] sshd[20571] general protection ip:7fa242dca6f3 sp:7fff272c9=
d40 error:0 in libcrypto.so.1.0.0[7fa242cc5000+1ca000]
[453669.290896] sudo[20578]: segfault at 0 ip           (null) sp 00007ffff=
97d89c8 error 14 in sudo[400000+1a000]
[453711.410834] sudo[20581]: segfault at 0 ip           (null) sp 00007fffe=
07e36f8 error 14 in sudo[400000+1a000]

The only recovery I have found is to reboot the machine.

Thanks,

Steven
