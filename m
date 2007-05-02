From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46383422.50007@domain.hid>
References: <bJZU8yAy.1178088859.4958920.dchabal@domain.hid>
	<46383422.50007@domain.hid>
Content-Type: text/plain
Date: Wed, 02 May 2007 09:34:26 +0200
Message-Id: <1178091266.5111.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai unstable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-05-02 at 08:48 +0200, Jan Kiszka wrote:
> I.e. !CONFIG_SMP doesn't boot at all when CONFIG_IPIPE is enabled? Same
> here: try the patch and !CONFIG_PCI_MSI, then catch the console output.

.config welcome.

Does this break over qemu, or real hw?

-- 
Philippe.



