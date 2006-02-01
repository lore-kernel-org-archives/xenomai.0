Message-ID: <43E07B8A.50606@domain.hid>
Date: Wed, 01 Feb 2006 10:12:42 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <43DE1DAD.8050302@domain.hid>
	<43DE2505.7000709@domain.hid>	<43DE3A90.4040107@domain.hid>
	<43DE3F74.2070402@domain.hid> <43DE43C7.3080608@domain.hid>
In-Reply-To: <43DE43C7.3080608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG] version mismatch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

in ksrc/arch/powerpc/patches/adeos-ipipe-2.6.14-ppc-1.2-00.patch:

   #define IPIPE_ARCH_STRING        "1.1-02"

shouldn't this be

   #define IPIPE_ARCH_STRING        "1.2-00"

-- 

Anders Blomdell

