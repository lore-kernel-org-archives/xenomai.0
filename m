Message-ID: <448C0FBF.3020707@domain.hid>
Date: Sun, 11 Jun 2006 14:42:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT
References: <02AA386EB831044F8537A696BA785C78A666A9@domain.hid>
In-Reply-To: <02AA386EB831044F8537A696BA785C78A666A9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: xenomai@xenomai.org

Landau, Bracha wrote:
> Under what circumstances must one configure the kernel with CONFIG_PREEMPT when running Xenomai-based code?
> 

This option is not directly related to Xenomai. You may want to set
CONFIG_PREEMPT if you need increased preemptibility for normal Linux
tasks (including Xenomai tasks executing Linux services in secondary
mode), but you can perfectly use CONFIG_NONE as well when overall system
performance counts.

Jan

