MIME-Version: 1.0
Date: Sun, 20 Sep 2015 02:58:58 +1200
Message-ID: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

Having installed Xenomai, I am wanting to test Xenomai.

If I understood the guide correctly under the title "Installing the Xenomai
libraries and tools", I would need to compile the libraries as well as the
test apps. For that I need to do by executing the command below in the
xenomai_root which in my case is xenomai_root=xenomai-3. However, the
configure file is not found. I am totally confused of what have I done
wrong? Any helps/advise would be appreciated.

$xenomai_root/configure CFLAGS="-march=armv4t" LDFLAGS="-march=armv4t" \
  --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi- --with-core=cobalt

Thank you

Lim
