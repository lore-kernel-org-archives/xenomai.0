MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 11 May 2020 15:51:10 +0800
Message-ID: <CAAvDm6ZbtJJPRfFPDhsxpR-njnJfEHvrJvG0Jrr=ob3=O-08pA@mail.gmail.com>
Subject: Why xddp-stream demo process could not be terminate by ctrl + C.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
     I could run the xddp-stream demo process normally indeed.
     But when i intend to terminate the process by ctrl+c, nothing has
happened.
     The only way i found useful is to use the shell command(sudo killall
-9 xddp-stream) to terminate it.
     I*'m really confused.*
*     As per the source code of
xddp-stream(https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9//demo/posix/cobalt/xddp-stream.c
<https://gitlab.denx.de/Xenomai/xenomai/-/blob/v3.0.9//demo/posix/cobalt/xddp-stream.c>),
there no api used to capture the ctrl+c signal.*
     Thank you for your attention.
     Look forward to hearing from you.
