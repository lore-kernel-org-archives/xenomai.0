MIME-Version: 1.0
From: =?UTF-8?B?546L57S56I+v?= <oiz5201618@gmail.com>
Date: Sat, 14 Jan 2017 08:45:59 +0000
Message-ID: <CAL3s=qCri+QLNFBC-07WG4fo8FxO6LDeWiWA-XazXkpnQbB8cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] How to specify kernel space and user space library.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello, I am student from Taiwan.
Thanks in advanced for any suggestion.

I trying to write a RTDM-based  PWM module for kernel space on
raspberry pi3.

I notice the Xenomai3 follow the split source model, but I have no idea
where the kernel library is. I follow the installation guide. I copy the
whole
directory which is under the $(target) into target system root after
`make DESTDIR=$(target) install`. All I find is usr/xenomai/include which
belongs to userland.
Do I miss something?
What should I copy to the target system additionally?

Regards,
Hua
