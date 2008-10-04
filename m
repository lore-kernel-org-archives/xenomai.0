Message-ID: <48E7CDA7.1010102@domain.hid>
Date: Sat, 04 Oct 2008 22:10:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270809260610w4573446x507ef059d4b3ca0b@domain.hid>	<48DD05F2.4040203@domain.hid>
	<2b490f270809301326jd381307md432bd4cdfe36d3b@domain.hid>
In-Reply-To: <2b490f270809301326jd381307md432bd4cdfe36d3b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dehann Fourie wrote:
> Hi,
> 
> Sorry for the lack of information, I'm still bit of a new guy. I have found
> the following (I do use a mlockall(current | future)):
> 
> When i declare larger arrays in the real-time task I get the segmentation
> fault. This is when I declare as follows
> double arr[10000]; //some KB sized value
> 
> When I use malloc I don't get the problem. My question now is where does the
> first one declare the memory. I am assuming that the malloc declares strait
> into the RAM, becuase there I am safe to declare a couple of MB?

It depends on where you declare double arr[10000]. If this is outside of
any scope, then it ends up in an anonmous map. If this is declared in a
function, then it ends up on the current thread stack, so, in this case
the current thread stack has to be large enough to allow such an
allocation (in your case, sizeof(arr) == 80000, that is around 80Kbytes).

-- 
					    Gilles.

