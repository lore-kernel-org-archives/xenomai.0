MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 15 Mar 2013 14:10:51 +0100
Message-ID: <CAMJ=MEc9W3KvNuL6nLQUt_jDPY1zBfsEZJH2pQZs2kJj7g+KBg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai-forge: psos skin does not take t_start flags into
	account
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

In august last year I reported a problem with round-robin scheduling
in the pSOS skin.
See mail thread "xenomai-forge: round-robin scheduling in pSOS skin".

Now that we stepped up to the latest version of Xenomai-forge, I was
retrying the same test I did at that time.
I observe that the situation has been improved: the roundrobin
scheduling as such is now working well,
but there is an issue with the initial flags passed to the t_start call.

The flags are not correctly taken into account by the t_start call.
The complete testcode is attached to the mail.

I basically create 2 tasks which both consume all cpu power for some time.
If I create the tasks with timeslice enabled:
    t_create("WORK",10,0,0,0,&tid);
    t_start(tid,T_TSLICE, perform_work, args);

I get this result:

# taskset 4 ./roundrobin.exe
   0"000.493| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected [--enable-debug=
=3Dfull]
0 -> 7196
1 -> 0

If I explicitly add code in the taskbody to enable the timeslicing:
  unsigned long old_mode;
  t_mode((T_TSLICE|T_NOTSLICE),T_NOTSLICE, &old_mode);
  t_mode((T_TSLICE|T_NOTSLICE),T_TSLICE, &old_mode);

I get this:

# taskset 4 ./roundrobin.exe
   0"000.491| WARNING: [main] Xenomai compiled with full debug enabled,
                              very high latencies expected [--enable-debug=
=3Dfull]
0 -> 3600
1 -> 3592

The latter is the correct behavior: both tasks get equal cpu power.
Note the t_mode is called 2 times to make sure the change of the state
stored in the task object is taken into account.

---
Ronny
-------------- next part --------------
A non-text attachment was scrubbed...
Name: roundrobin.c
Type: text/x-csrc
Size: 1203 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130315/67f4636=
4/attachment.c>
