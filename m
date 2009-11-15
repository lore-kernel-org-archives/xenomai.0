Message-ID: <4B004A03.1030503@domain.hid>
Date: Sun, 15 Nov 2009 19:35:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Replace bind.h with a convenience library.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Hi,

in preparation for adding more code common to all skins (signals
handling), I split bind.h into three files, which are compiled as a
convenience library linked to every skin library.

I have pushed this first modification for review, you can see the
changes here:
http://git.xenomai.org/?p=xenomai-gch.git;a=commit;h=05a32ee49ceedddc44024c2fc2f6125fdfe344b9

You may find the patch on the xenomai-git mailing list, if you want to
comment it inline.

Regards.

-- 
					    Gilles.

