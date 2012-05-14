From: "Leopold Palomo-Avellaneda" <leo@domain.hid>
Date: Mon, 14 May 2012 09:45:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201205140945.34788.leo@domain.hid>
Subject: [Xenomai-help] Xenomai on kernel 3.x and x86
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

Hi,

sorry if the question it's obvious but I have not understood the information 
that I have found. I have read the roadmap of Xenomai [1] and it's not clear 
to me what should I have to do if I would want to use xenomai in a kernel 
3.x.

As far as I understand the idea it's to go to Xenomai 3 with the prempt patch 
or a co-kernel option. Then xenomai will be the interface to the realtime 
kernel. From the user point of view, no matter if xenomai will use the rt-
preemt or the co-kernel option. Also, the driver option will be the rtdm.

But I don't understand if the Adeos patch will survive (at least in x86) or 
what will happen. I understand that the co-kernel option is the same that we 
have now (2.6) with the adeos patch, but I have not be able to find an Adeos 
patch for a x86 platform in a 3.x kernel.

Please, someone could clarify this.

Thanks in advance,

Leo



[1] http://www.xenomai.org/index.php/Xenomai:Roadmap

-- 
--
Linux User 152692
Catalonia

