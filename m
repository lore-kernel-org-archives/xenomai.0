MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 23 Apr 2020 11:55:07 +0800
Message-ID: <CAAvDm6Z6u56WwdtCX1Uy92PY2mWpBcr7x81U3Ke6TkvjA44X9g@mail.gmail.com>
Subject: Must I implement the vm_operations while rtdm_mmap_to_user function
 is to be called?
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
      Must I implement the vm_operations while
rtdm_mmap_to_user function is to be called?
      Vm_operations is to be executed on the vm_area
of the user memory range, as per the documentation,
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__util.html#ga819ed9b5bbfd95e4f833c7f70732cebd
.
     I wonder when the vm_operations is to be called
and what function it supplys.When should I
implement the vm_operations.

     Thanks for your attention.
