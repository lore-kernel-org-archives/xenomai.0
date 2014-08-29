Message-ID: <54006F81.4020303@xenomai.org>
Date: Fri, 29 Aug 2014 08:18:09 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu>
 <3C04D010-D511-4D3D-A90E-474B71DA6425@gatech.edu>
In-Reply-To: <3C04D010-D511-4D3D-A90E-474B71DA6425@gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Analogy PCI Slot issues?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/28/2014 10:40 PM, Yogi A. Patel wrote:
> Forgot to add - the lspci output shows the following for the NI DAQ:
> 
> 01:0a.0 Unassigned class [ff00]: National Instruments PCI-6036E

could you provide the Xenomai version and the whole output of dmesg and lspci when
the error occurs as well as /proc/analogy/devices and /proc/analogy/drivers?

> 
> Yogi
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJUAG+BAAoJECDcy2IJkagRrXEH/1Gx2+z9rAbrss/qq8wpFB1z
+P4TI1WKpl+T7UjSmq1VCqbF7uNsJuJU02gEwfRFRecZz98dDckFxeJ87B6nbIfS
cod/9B8yDyYBeCS3Ag498PqQoGxWWdrtl0F1YoZLd9DHjRQTO5GNnKrnnfP19fnE
0XvGSAV72oYGeYjy9kKyepXWiFzhdUw+l0eD6Vn/Y5O93ecGphYOfYSbg5loD6nS
FsYQKW1LSz/wonbfHjCOol1jLmWrUXu0QmucmARaHK+x3aDQkoCom2ywzqCDuC7j
WVFWkdAwo1Xa3JcrUwVE6wvaaywilTfL5Li23xJYaWpQAYeiPsWh7fR7ln/0vyI=
=k1Sh
-----END PGP SIGNATURE-----

