Message-ID: <0C53F2DBA565D411885300508B553B5204CCEAE7@domain.hid>
From: aaron durbin <aarondurbin@domain.hid>
Date: Wed, 4 Aug 2004 08:35:37 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Adeos-main] adeos porting
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "'adeos-main@gna.org'" <adeos-main@gna.org>

Hi,

I am planning on porting ADEOS over to m68knommu (ColdFire based)
architecture.  I have read the porting guidelines, however they are a little
outdated. Currently I am using the recently released
adeos-linux-2.6.7-i386-r6c6.patch patch for a basis. I was wondering if
there was any more recent documentation on the API so I know exactly what
calls should be performed in entry.S.

The issue I am running into is that the version 2 core of ColdFire does not
have user/kernel stack support in hardware.  Therefore in entry.S needs to
disable interrupts to make the stack switch atomic.  I was wondering if it
would be sufficient to just stall the pipeline for linux at this point and
make sure to unstall as apposed to disabling interrupts.

My plans are to first port over ADEOS then go for RTAI.  The two coupled
together look very promising, and I am hoping they will work as well for
ColdFire as it does for x86.  

Thanks for the help,
Aaron Durbin 

