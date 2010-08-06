Message-ID: <4C5C3093.90903@domain.hid>
Date: Fri, 06 Aug 2010 17:56:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimPXWv2octL1y5Hy+rW1yOwEwxo3fY8g_cNrY9v@domain.hid>	<4C5C2BBC.7000502@domain.hid>
	<AANLkTimYqC1xJHOucngM+zT0GQqhonJiCLwvbosPpU5j@domain.hid>
In-Reply-To: <AANLkTimYqC1xJHOucngM+zT0GQqhonJiCLwvbosPpU5j@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with the installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ana Carolina Cardoso de Sousa <anacsousa1@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Ana Carolina Cardoso de Sousa wrote:
> [ 1667.628675] Disabling lock debugging due to kernel taint

Your kernel is tainted. It means that you are using some binary modules.
Binary modules do not work with an Adeos patched kernel unless you
recompile them. Did you recompile your binary-only module?

Please do not drop the CC.

-- 
					    Gilles.

