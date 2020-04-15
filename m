MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Wed, 15 Apr 2020 10:44:38 +0800
Message-ID: <CAAvDm6aYQd5w1ST2HviwGsh-oETncue8e_6OAs1PYTNa3w4xrQ@mail.gmail.com>
Subject: I wonder why it calls pipeline_syscall function firstly when i call
 the open function to aquire the handle of a rtdm driver?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi=EF=BC=8C

I am using xenomai-v3.0.9 with linux3.0.9.

I wonder that why it calls pipeline_syscall function firstly
when i call the open function to aquire the handle of a rtdm driver?

The related call trace log for kernel is listed below.

Some notes.

I am quite conscious of the reason which causes the error.
So i am not intend to ask help to slove the problem showed in the log
listed below.

I have set the context_size of the rtdm_driver struct to a huge number in
my rtdm driver.
So the error occurs when i call the open function to aquire the rtdm handle=
.
I am not confused any more after i have read the source code.

But i could not make it clealy why it calls pipeline_syscall function
firstly.

Looking forward to hearing from you.
Best regards.
