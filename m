Message-ID: <49A3C5EB.4020707@domain.hid>
Date: Tue, 24 Feb 2009 11:03:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>	<49A1DEBE.6020002@domain.hid><BAY135-W25DA8BBF5E569E370DB25DC6AE0@domain.hid>	<49A2D47D.90609@domain.hid><BAY135-W50A146D755045D42A23F66C6AE0@domain.hid>
	<49A323CE.3010302@domain.hid>
	<6B8F1229FFBDCA47BA5C9712C46F18DFABCE46@domain.hid>
In-Reply-To: <6B8F1229FFBDCA47BA5C9712C46F18DFABCE46@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_create with mode T_CPU(1)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Schaefer <thomass@domain.hid>
Cc: xenomai@xenomai.org

Thomas Schaefer wrote:
> Hi,
> 
> unfortunately this doesn't work.
> I tried a few other svn revisions. 
> 4610 is the last one that works correctly and I can compile without an
> error message.
> The next revision that successfully compiles hangs.

Good news: Problem reproduced with your .config. Debugging now.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

