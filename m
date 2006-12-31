Message-ID: <b647ffbd0612310852h4e72fd4fj5e04f0c7fb185ded@domain.hid>
Date: Sun, 31 Dec 2006 19:52:40 +0300
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] xenomai&linux
In-Reply-To: <1167491827.13768.8.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1167491827.13768.8.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 30/12/06, Victor Shulyak <V.I.Shulyak@domain.hid> wrote:
> Hello All,
>
> RT_Pipe can be used to communicate between Xenomai tasks and Linux
> processes. Are there another Xenomai ways to communicate between them?
> Can I use Linux IPC in Xenomai tasks?

Yes, you can do it. But the difference is that a xenomai task migrates
in the secondary domain in this case - whenever a secondary domain
call is issued (native linux system call) and linux IPC is such a
case.
While using the real-time part of the pipe interface a xenomai task
stays in the primary domain. Hence, real-time determinism is preserved
while in the former case it's lost.

>
> Thanks, Victor
>

-- 
Best regards,
Dmitry Adamushko

