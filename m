Message-ID: <4BB4FE00.7040101@domain.hid>
Date: Thu, 01 Apr 2010 22:11:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <hp0bdv$mp4$1@domain.hid>
In-Reply-To: <hp0bdv$mp4$1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] cyclictest -tn where n!=1 causes segfault with
 Kilauea
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Berger <gmane@domain.hid>
Cc: xenomai@xenomai.org

Robert Berger wrote:
> ./cyclictest -t2
> Segmentation fault

This issue is fixed by commit 428aa42410efe575f7bb9729447e6dc49159ef5e
http://git.xenomai.org/?p=xenomai-2.5.git;a=commit;h=428aa42410efe575f7bb9729447e6dc49159ef5e

-- 
					    Gilles.

