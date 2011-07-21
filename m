Message-ID: <be312d912dcaef8867b47d2e8aaa546b.squirrel@domain.hid>
In-Reply-To: <42ced071bc2bf4dbf2dc6f74746817be.squirrel@domain.hid>
References: <42ced071bc2bf4dbf2dc6f74746817be.squirrel@domain.hid>
Date: Thu, 21 Jul 2011 11:36:31 +0200
From: "Wong Sheng Chao" <wong@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Analogy Differential Mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all

I'm still trying to figure out how to configure my NI card to read voltage
signal in Differential Mode rather than single ended. I had been reading
the API and it seems that I need to create a structure and define it's
member accordingly

struct a4l_channel {
	unsigned long flags; /*!< Channel flags to define the reference. */
	unsigned long nb_bits; /*!< Channel resolution. */
};
typedef struct a4l_channel a4l_chan_t;

with the member flags being one of the following,

A4L_CHAN_AREF_GROUND 0x1
A4L_CHAN_AREF_COMMON 0x2
A4L_CHAN_AREF_DIFF 0x4
A4L_CHAN_AREF_OTHER 0x8

and in my case A4L_CHAN_AREF_DIFF

My question is which function should I use to send this structure to
configure the reference mode and where? I'm thinking it should be between
these two functions, but i'm still not sure how I can achieve this.

a4l_open();

//configure differential mode here.

a4l_fill();


My current setup is as follow
Distribution: Ubuntu 10.04
Linux kernel: 2.6.37.3
adeos patch: 2.9-00
xenomai: 2.5.6
DAQ card: National Instruments PCI_6034E

Thanks
Chao




