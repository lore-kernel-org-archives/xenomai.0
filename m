MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18217.63620.673826.481658@domain.hid>
Date: Thu, 1 Nov 2007 17:02:12 +0100
In-Reply-To: <200711011546.lA1FkDVY014154@domain.hid>
References: <200711011233.lA1CX9wf032489@domain.hid>
	<200711011546.lA1FkDVY014154@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
 > Hi all,
 > 
 > I found what was causing the problem (compiling with g++), it's simply that
 > the struct initialization is not g++ compatible :
 > 
 >  __attribute__((weak)) struct __xn_tscinfo __xn_tscinfo = {
 >          .type = -1
 >  };
 > 
 > should be :
 > 
 > __attribute__((weak)) struct __xn_tscinfo __xn_tscinfo = {
 >          type : -1
 >  };
 > 
 > I tested this with g++ and gcc versions 4.1.2 and it compiles correctly.

...but is fragile, if we are not trying to initialize the structure
first member, g++ says:
sorry, unimplemented: non-trivial designated initializers not supported

So, we are better off do it the C++ way.

-- 


					    Gilles Chanteperdrix.

