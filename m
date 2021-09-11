MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Sat, 11 Sep 2021 19:46:05 +0200
Message-ID: <CAK6DXL1OLq6eTfnGp9AMsLVo664+tE2KO=_Uq+GVKpxPamcMxw@mail.gmail.com>
Subject: setup RTnet
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone;
I was trying to setup RTnet but I found some problems. After removing
non-rt e1000e module and loading rt one, when I run rtnet start I got the
same output as
https://www.mail-archive.com/xenomai@xenomai.org/msg18342.html. I know this
is a known issue since the rt_e1000e doesn't work very well with i219-V
Intel ethernet controller, and I checked out patches in
https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html. Anyway I
experienced some compile time issues with Xenomai 3.1, Linux 5.4.77. Do you
have an updated version tested toward this kernel version? On gitlab I see
the driver still doesn't support the controller.
Thank you very much for the effort.

-- 
Marco Barletta
