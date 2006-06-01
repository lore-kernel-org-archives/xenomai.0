Message-ID: <39455.155.98.4.39.1149195102.squirrel@domain.hid>
In-Reply-To: <447F49C8.4090609@domain.hid>
References: <39142.155.98.4.39.1149186052.squirrel@domain.hid>
	<17535.18007.179715.207040@domain.hid>
	<447F49C8.4090609@domain.hid>
Date: Thu, 1 Jun 2006 14:51:42 -0600 (MDT)
Subject: Re: [Xenomai-help] xnpod help
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I think there's a little bit of a misunderstanding.  I'm not trying to
write my own skin.  I'm new to xenomai and I'm just trying write a simple
kernel module that starts a periodic realtime thread.  Write now I'm just
trying to have it write a simple message to printk but eventually I'm
going to want it to write to a DAC to control a servo.  I've been browsing
the xenomai API linked off the main website and I thought that using the
nuclues was the prefered method for doing this but I get the feeling now
that is not the case.  My ultimate goal is to have a realtime kernel-space
thread that acts as a pid-controller that communicates and synchronizes
with a non-realtime user-space application that displays pertinent
information to the user.  How would you recommend going about doing that? 
Thanks.
-Brandt


