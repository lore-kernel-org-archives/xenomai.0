MIME-Version: 1.0
From: Manikanta Mylavarapu <mylavarapumanikanta23@gmail.com>
Date: Wed, 7 Nov 2018 11:45:27 +0530
Message-ID: <CAPNo5QJdOpN8cztKGNZjifmP-Bx4wRyOq0XAw7HM1UQ+Op5E3Q@mail.gmail.com>
Subject: Re:32bit on 64bit in xenomai 2.6.0
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

Dear all,

I am trying to run 32bit applications on 64bit xenomai. I installed xenomai
2.6.0 on fedora 13 x86_64. I installed all 32bit GCC lib & c librarys
(glibc-devel.i686 & going.i686).

I made one hello world sample (non-rt) app, it is giving error while running
 "-bash: ./a.out: cannot execute binary file" but the same a.out is running
fine on "plain fedora13 x86_64".

My question is on xenomai 2.x can we run 32bit rt & non-rt app on 64bit
kernel? Please help me.
