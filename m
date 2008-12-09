From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Tue, 9 Dec 2008 08:32:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812090832.43063.roberto.bucher@domain.hid>
Subject: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hi

I have some problems with the last patches for kernel 2.6.26.x and 2.6.27.x.

I found first the problem using the RTAI patch, but then I tryed the original 
adeos patch and the problem remains and I can reproduce it every time.

When I start scilab-gtk from a patched kernel, RTAI or Adeos, the system 
freezes completely.
This problem doesn't happen with a 2.6.24.x kernel or with a non patched 
2.6.27.x kernel.

Paolo Mantegazza and other RTAI users have the same problem, but Paolo for 
example is not able to reproduce it in the same matter. By him for example the 
problem happens sometimes after launching Acrobat Reader. On my system it 
happens sometimes when I try to download a file from the web too.

The probem persists with the last 2.6.27-x86-2.2-01.patch. I didn't try a 
2.6.25.x kernel, but it seems to be ok (after Paolo Mantegazza).

Any idea?

Thanks in advance

Roberto

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://www.dti.supsi.ch/~bucher

