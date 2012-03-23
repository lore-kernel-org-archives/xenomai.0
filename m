Message-ID: <4F6C6925.8000503@domain.hid>
Date: Fri, 23 Mar 2012 13:14:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F6A065E.9030309@domain.hid> <4F6B45B3.7080904@domain.hid>
	<4F6B554A.4080008@domain.hid> <4F6C3D32.70801@domain.hid>
	<4F6C5C07.4090001@domain.hid>
In-Reply-To: <4F6C5C07.4090001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using xenomai with standard ethernet driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2012-03-23 12:18, Roberto Bielli wrote:
> Hi Jan,
> 
> i want to send and receive custom raw packets over ethernet.
> is it possibile with RTnet or it sends only rtnet packets ?
> 
> Thanks for your response.

RTnet is modular, and if you use the stack a sketched, you are free to
define the payload of the sent Ethernet frames on your own.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

