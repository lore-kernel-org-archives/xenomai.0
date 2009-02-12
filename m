Message-ID: <49949E48.4010106@domain.hid>
Date: Thu, 12 Feb 2009 23:10:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7ed3bc8b0902120904r800de72q97e694001600051e@domain.hid>
	<499480EE.3040403@domain.hid> <49948E51.9000509@domain.hid>
In-Reply-To: <49948E51.9000509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Known-to-work motherboards?
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
Cc: xenomai@xenomai.org, Stuart O Anderson <soa@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Stuart O Anderson wrote:
>>> If there isn't a list online that I've missed, is anyone running
>>> xenomai on a relatively recent machine with 8 or more cores without
>>> problems?  If so, can you provide hardware specs?
>> Xenomai will have scalability problems when running on an 8 cores system
>> (if you intend to run real-time tasks on each of the 8 cores).
>>
> 
> We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 cores
> used by RT tasks. I've some patch hanging around that restricts Xenomai
> (specifically its host timer hook) to a CPU subset in order to mitigate
> the scalability issues - guess I should finally get it in shape and post it.

The host timer already runs on only one CPU.

-- 
					    Gilles.

