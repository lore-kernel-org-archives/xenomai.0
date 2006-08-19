From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17639.2178.158208.80020@domain.hid>
Date: Sat, 19 Aug 2006 14:48:02 +0200
Subject: Re: [Xenomai-core] Re: Test, benchmark
In-Reply-To: <44E6BF53.4000809@domain.hid>
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid> <44E6009E.7020304@domain.hid>
	<44E606B9.6050406@domain.hid> <44E6BF53.4000809@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > list="a,b,c,d"
 > for option in `echo $list|sed -e's/,/\n/g'`; do
 > 	case $option in
 > 	a)
 > 		do_this
 > 		;;
 > 	b)
 > 		do_that
 > 		;;
 > 	...
 > 	esac
 > done


What about:

save_ifs="$IFS"
IFS=,
for option in $list; do
     case $option in
...
     esac
done
IFS="$save_ifs"

-- 


					    Gilles Chanteperdrix.

