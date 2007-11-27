Message-ID: <5a4b7020711270211i9c996a8l25ba908cac47ae5b@domain.hid>
Date: Tue, 27 Nov 2007 18:11:25 +0800
From: "jie zhang" <xenomai.rtai@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] kernel panic - not syncing: VFS unable to mount root
	fs on unknown-block(0, 0) and mkinitrd
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

hi ,
I have a question, I built xenomai-2.4-rc5 and linux-2.6.23 on pc with
debian distribution and same xenomai and same linux-2.6.23 on laptop
with ubuntu, I always meet

cannot open root device "hda2" or unknown-block(0,0)
please append a correct root= boot option; here are the available partitions:
kernel panic - not syncing: VFS unable to mount root fs on unknown-block(0,0)

and Gilles Chanteperdrix told me I should mkinitrd, and I  do that,
then it is booting now, but I want to know why I need this step just
because in slackware distribution, I don't do that   Thank you

