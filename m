From: steve freyder <steve@freyder.net>
Subject: On update to 3.1, select() starts returning errno == EADV
Message-ID: <e9111251-205c-1f96-5a0f-33456b576334@freyder.net>
Date: Sun, 6 Jun 2021 14:24:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello Xenomai group,

We're in the process of moving from Xenomai 3.0.7/4.1.18 to 
3.1/4.14.85.  Testing one of our apps we found that select() was 
returning -1 with errno == EADV.  This app was written before we knew 
about the recommendation from Philippe contained in this message:


https://xenomai.org/pipermail/xenomai/2019-August/041435.html


We're not mixing Linux/Xenomai descriptors in the select set, the fd's 
(4 of them in this case) are all pointing to Linux FIFOs 
(/dev/somename{1..4}), and we'll ultimately start using __STD(select) 
like the above msg says we should (until this was found we were unaware 
of the importance of using __STD(select)).

But my reason for posting is my confusion about the EADV return.  The 
message says:

 >>> Switch from -EBADF to -EADV to notify userland that RTDM does not
 >>> manage a file descriptor, which cannot conflict with any sensible
 >>> error code the Cobalt core or any RTDM driver may return.

But also says:

 > We still want to receive -EBADF on wrong fildes appearing in select()
 > descriptors.

Taking both of those into account, I looked at the code in 
lib/cobalt/select.c which implements the glibc fallback:

         if (err == -EBADF || err == -EPERM || err == -ENOSYS)
                 return __STD(select(__nfds, __readfds,
                                     __writefds, __exceptfds, __timeout));

In the specific case of our app, had the above code included a check for 
-EADV, things would operate as they did under 3.0.7.  However, the 
statement "still want to receive -EBADF on wrong fildes appearing in 
select" suggests that the check for -EADV shouldn't be necessary.  There 
must be something at a lower level that is returning -EADV instead of 
-EBADF when faced with a Linux FIFO fd, or, if -EADV is appropriate then 
it seems adding a check for -EADV along with -EBADF, -EPERM, and -ENOSYS 
is also appropriate if backwards compatibility is desired for select().


Thank you,

Best regards,

Steve




