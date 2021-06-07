Subject: Re: On update to 3.1, select() starts returning errno == EADV
References: <e9111251-205c-1f96-5a0f-33456b576334@freyder.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ee25e5a5-4cbb-25d0-df96-5cd8bf9fbd8f@siemens.com>
Date: Mon, 7 Jun 2021 07:52:22 +0200
MIME-Version: 1.0
In-Reply-To: <e9111251-205c-1f96-5a0f-33456b576334@freyder.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: steve freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.06.21 21:24, steve freyder via Xenomai wrote:
> Hello Xenomai group,
> 
> We're in the process of moving from Xenomai 3.0.7/4.1.18 to
> 3.1/4.14.85.  Testing one of our apps we found that select() was
> returning -1 with errno == EADV.  This app was written before we knew
> about the recommendation from Philippe contained in this message:
> 
> 
> https://xenomai.org/pipermail/xenomai/2019-August/041435.html
> 
> 
> 
> We're not mixing Linux/Xenomai descriptors in the select set, the fd's
> (4 of them in this case) are all pointing to Linux FIFOs
> (/dev/somename{1..4}), and we'll ultimately start using __STD(select)
> like the above msg says we should (until this was found we were unaware
> of the importance of using __STD(select)).
> 
> But my reason for posting is my confusion about the EADV return.  The
> message says:
> 
>>>> Switch from -EBADF to -EADV to notify userland that RTDM does not
>>>> manage a file descriptor, which cannot conflict with any sensible
>>>> error code the Cobalt core or any RTDM driver may return.
> 
> But also says:
> 
>> We still want to receive -EBADF on wrong fildes appearing in select()
>> descriptors.
> 
> Taking both of those into account, I looked at the code in
> lib/cobalt/select.c which implements the glibc fallback:
> 
>         if (err == -EBADF || err == -EPERM || err == -ENOSYS)
>                 return __STD(select(__nfds, __readfds,
>                                     __writefds, __exceptfds, __timeout));
> 
> In the specific case of our app, had the above code included a check for
> -EADV, things would operate as they did under 3.0.7.  However, the
> statement "still want to receive -EBADF on wrong fildes appearing in
> select" suggests that the check for -EADV shouldn't be necessary.  There
> must be something at a lower level that is returning -EADV instead of
> -EBADF when faced with a Linux FIFO fd, or, if -EADV is appropriate then
> it seems adding a check for -EADV along with -EBADF, -EPERM, and -ENOSYS
> is also appropriate if backwards compatibility is desired for select().
> 

I had a regression report on this topic internally as well, but no
proper reproduction case. Do you have a self-contained test for us?

The goal is clear: EADV should remain internal, not visible by select()
callers (or any other service, see 5f14ea8ae6d6).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

