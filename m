From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17424.17324.137254.586833@domain.hid>
Date: Thu, 9 Mar 2006 16:03:08 +0100
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
In-Reply-To: <44104044.20606@domain.hid>
References: <006f01c64312$a28ab730$a10a10ac@domain.hid>
	<44104044.20606@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:
 > Christopher Stone escreveu:
 > > ...
 > > Vendor specific API's are like drugs, once you get hooked on them, it is
 > > difficult to incur the cost of kicking the habit. With Xenomai you can use
 > > any of a number of skins, but, would be wise to consider the POSIX skin. By
 > > using the industry standard POSIX API your code remains portable and more
 > > future proof. 
 > >   
 > Actually it depends. At the moment, as far as I know, RTDM drivers are 
 > not able to communicate to POSIX written programs in every way, like it 
 > does with programs written using the native API. 

Actually there is a major change around 2.1-rc3: most services of the
POSIX skins may be used by threads created by other skins. The exceptions to
this rule are services which involves the "POSIX skin specific" part of
Xenomai POSIX skin threads, namely only services involving signals and
cancellation.

Also note that in user-space, the RTDM and POSIX skins are fully integrated.

-- 


					    Gilles Chanteperdrix.

