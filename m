Message-ID: <43D2B94C.3000202@domain.hid>
Date: Sat, 21 Jan 2006 23:44:28 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] wake_up_interruptible ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi all!

I've got a kernel module which creates a chrdev.
In the read file operation I have a interruptible_sleep_on.
Now I want to wake it up from an IPIPE interrupt handler
(i.e. unblock the read operation from user-space on the
chrdev), but I bet wake_up_interruptible is forbidden
in HRT context, isn't it ?

Thanks and best regards,
Hannes.



