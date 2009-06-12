From: Sebastian Smolorz <smolorz@domain.hid>
Date: Fri, 12 Jun 2009 11:48:37 +0200
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>
In-Reply-To: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906121148.37732.smolorz@domain.hid>
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>, xenomai@xenomai.org

Peter Soetens wrote:
> I'm looking for a more agile way to run my unit tests (and build farm)
> on a Xenomai system, without running them directly my development
> system (nor rebooting to a Xenomai patched kernel). I was hoping that
> a virtualisation solution would do the trick. Does anyone have
> experience with running a Xenomai patched kernel + applicaiton in
> vmware or another virtualisation package ?
>

Xenomai runs perfectly inside qemu, without real-time guarantees, of course.

-- 
Sebastian


