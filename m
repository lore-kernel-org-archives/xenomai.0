Message-ID: <51EEF1BC.1030504@xenomai.org>
Date: Tue, 23 Jul 2013 23:12:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEc70e-1C+ZFVHzZ1ECDgomXThLR3FypCqPcJdP1kbwxQQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEc70e-1C+ZFVHzZ1ECDgomXThLR3FypCqPcJdP1kbwxQQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] psos/sm_p: error handling not correct.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 07/22/2013 10:07 AM, Ronny Meeus wrote:
> Hello
>
> If the sm_p service is called with the SM_NOWAIT flag and the semaphore is
> not available the EWOULDBLOCK error code is returned to the application.
> This is not correct since the application expects to see only pSOS
> errorcodes.
>
> The attached patch solves the issue.
>

Merged, thanks.

> I have also included a small test application that can be used to verify
> the code.
>
> Best regards,
> Ronny
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: semaphore-nowait-return-code.patch
> Type: application/octet-stream
> Size: 855 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130722/f191924c/attachment.obj>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: simple_sm_p.c
> Type: text/x-csrc
> Size: 715 bytes
> Desc: not available
> URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130722/f191924c/attachment.c>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

