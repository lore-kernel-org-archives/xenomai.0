From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 19 Sep 2008 20:47:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809192047.20277.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Signature of kernel_init of xenomai-solo?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi 
Shouldn't the signature not bee
STATUS kernelInit(FUNCPTR rootRtn, int argc, const char * argv[]);
instead of
STATUS kernelInit(FUNCPTR rootRtn, int argc, char *const argv[]);
I think this would be more like a classical definition "main".

I have a classical definition of
  int main(int argc, char *argv[])
which permits mit to pass it to , const char * argv[]),
whereas char *const argv[] is not an allowd cast.


Best regards

-- 
NIklaus Giger


