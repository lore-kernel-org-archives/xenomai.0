MIME-Version: 1.0
From: Manikanta Mylavarapu <mylavarapumanikanta23@gmail.com>
Date: Tue, 30 Oct 2018 22:45:04 +0530
Message-ID: <CAPNo5QK_QktkN1=g733uRGZwM11FMWgdWi_z1_orvYBM6iY9JA@mail.gmail.com>
Subject: Re: rtdm_fd_is_compat () in xenomai 3.0
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

Hi to all,

I am running 32bit application on 64bit kernel i.e my driver compiled on
64bit.

In my driver I used rtdm_fd_is_compat(), to know user land request came
from 32-bit or 64bit app.

My doubt is what it will return if both the driver & app are different?

Regards,
Manikanta
