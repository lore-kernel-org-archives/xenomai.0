Message-ID: <4DE4AE03.9020509@domain.hid>
Date: Tue, 31 May 2011 10:59:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3FF315C710820E47A04E55C6F7D9B0AD78FA33@domain.hid>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD78FA33@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] UDP-receive-task stalls
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On 2011-05-31 10:34, roderik.wildenburg@domain.hid wrote:
> We face the problem that a Xenomai task which receives UDP-packets
> (secondary mode recvfrom()) on a high frequency ( every 50ms approx.
> 1200 Byte) stalls sporadically (few times a day). In this case the
> ROOT-task permanently shows the priority of the stalled task, the
> receive queue of the stalled task fills up (netstat -u) , the task never
> comes to live again . Attaching gdb or strace to this task stalls these
> tools also. Other tasks and Linux run as expected even other UDP-receive
> tasks!
> Any idea what can cause this problem or how we can debug the stalled
> task? (I think we had a similar problem with select() I presented in
> this list).
> We use:
> - Linux 2.4.25 PPC 
> - Xenomai 2.4.9

Do you depend on CONFIG_XENO_OPT_PRIOCPL? If not, switch it off, it may
be involved here.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

