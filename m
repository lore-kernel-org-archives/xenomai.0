Message-ID: <4E42DAFF.10801@domain.hid>
Date: Wed, 10 Aug 2011 21:24:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] mutex torture broken with native skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

the mutex-torture-native test is currently broken -head. The regression
seems to be due to commit 167ad3c5f6d322d8e2cf310e837c3f54056d7ba6

It means that condvars are probably currently broken on -head and it is
probably better to revert that commit for the time being.

-- 
                                                                Gilles.

