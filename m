From: Marco Jackel <ich@domain.hid>
Date: Wed, 02 Aug 2006 21:07:48 +0200
Message-ID: <eaqt5i$4l0$1@domain.hid>
References: <eaqrtk$vkb$1@domain.hid> <eaqsbk$vkb$2@domain.hid>
	<44D0F5DE.3010508@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <44D0F5DE.3010508@domain.hid>
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: problem with reading from rt_pipe with a normal
	linux process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Hint: read returns its error code in errno. What does that one tell you?

read returns -1, "operation not permitted"


