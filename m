Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Date: Thu, 03 Jun 2010 10:09:38 +0200
MIME-Version: 1.0
From: "stephane ancelot" <sancelot@domain.hid>
Message-ID: <op.vdpsychunuwxn3@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] rt_pipe_open / rt_pipe_delete bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

tryied in v2.4.10 :


I have opened a /dev/rtp7 pipe , and deleted it.

if I launch again the same program, rt_pipe_open replies with -EBUSY ....

Best Regards
S.Ancelot

