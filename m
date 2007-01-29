Subject: Re: [Xenomai-help] Patching latest Denx 2.4.25-devel kernel with
	xenomai-2.3.0 fails
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45B858EE.60301@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0198DD4D@is-hdq-exchange.marel.net>
	<45B7D0A7.3070904@domain.hid>  <45B858EE.60301@domain.hid>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 16:36:55 +0100
Message-Id: <1170085016.4973.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2007-01-25 at 08:14 +0100, Wolfgang Grandegger wrote:

[...]

> The attached patch fixes the problem by replacing "^" with "-1" for 
> "previous line". It works now with FC4 and FC6. Likely it's an 
> incompatibility issue between ed-0.2-3 ed-0.3-0.fc6.
> 

Merged, thanks.

-- 
Philippe.



