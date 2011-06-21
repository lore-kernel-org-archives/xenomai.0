Message-ID: <4E00B9BA.2050306@domain.hid>
Date: Tue, 21 Jun 2011 17:33:14 +0200
From: zenati <omar.zenati@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Number of arguments
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

Dear,

As known, the norm arinc653 is very strict and the API proposed should 
be respected. Some functions of the API need more than five arguments. 
However, the "SKINCALL" is limited to 5. If I want to increase, I have 
to modify the following files :
  - ./xenomai-2.5.6/include/asm-arm/syscall.h
  - ./xenomai-2.5.6/include/asm-blackfin/syscall.h
  - ./xenomai-2.5.6/include/asm-x86/syscall.h
  - ./xenomai-2.5.6/include/asm-powerpc/syscall.h
  - ./xenomai-2.5.6/include/asm-nios2/syscall.h

Is it possible? Is is a good idea ?

Thank you for your attention and your help.
Sincerely

Omar ZENATI

