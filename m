Message-ID: <b647ffbd0702091314y5c452cd2wc48f126763b9b3@domain.hid>
Date: Fri, 9 Feb 2007 22:14:54 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Strange deadlock.
In-Reply-To: <45CCCD10.9000008@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45CCCD10.9000008@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

> I found dead lock in my program and looking for reason, but i found
> something strange. Is possible mutex state looks like:
> [root@domain.hid /]# cat /proc/xenomai/registry/native/mutexes/coll_VDCP_1
> =locked by bus_monitor_proc[0] depth=1
> +vdcp[0030]m
> +bus_monitor_proc[0]

Just to put aside a few (quite) weird assumptions :

(1) did you have another task that has been using this mutex and has
(somehow) exited by the moment of lockup?

(2) bus_monitor_proc[0] is created once and never
exits_then_created_again while the program is running ?

TIA,

-- 
Best regards,
Dmitry Adamushko

