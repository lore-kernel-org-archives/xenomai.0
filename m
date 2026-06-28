Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011732D7FA
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661229; cv=none; b=NeR9rKCkoAZMfGUVcuAShN9XcTAtRw5kLedPom40bnN3lpJmCJG1B9r9v7Dfd0OpBagT2FDJRxGZ3LwOSXkrrJ3YP0rpLbweQDfzbyImGeBCo7JO3DF9QsQaqGbXw9E11B1mORfqkMy/4/AT8072VJv+y94a++K35HxxGJxRP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661229; c=relaxed/simple;
	bh=2ky+TIXb/h7bzwW64mhIB3fn/pMRivjNF9OLxCjuTwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C43Ru679qNXwmV0ocmMtbM32tlf/lJW7Cz3ftyGXiJMCLMO/gLBIDonLaYsLx8UN2Wv/SaERJ2ne1Aboi/18FKs5tv9PX8C5M3QTtJ5+31nFc5F5j0JBDszewy0b2pRzQHLySolpKqP0KeDmKmGXw2i0K8I16FsgCuZEgg/ubKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+6DkJ0M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+6DkJ0M"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49249707788so20582635e9.2
        for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782661226; x=1783266026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO0OX+dpZ5HpX7s3jWDeFyKGT1OqtjfvNdjF+pWZd2U=;
        b=S+6DkJ0M2roFsONSQpzs6d/Z88arro5RGDO16xqQTwpuVal29QoFckV0yqfKKnnYu8
         BICmtnoSahNCVFkuPBOBVeLon43OVcL0uw/piWXCE1zzrKgzRwjSvO3RwbPVhAB8yE+z
         39nRgkaC770e+4DfyFprQNMLp3mkxGAFoxGIgKRiLRUZs/b47s/Va0/MfM2OoZbNneAT
         Ki3qKdOE12KE+7qhzsZrn40ZIx/oKQNY08RXDLjrW4NN6TGWKD0iJms7CucHsMX0OMT+
         VCYpnDdYkFdgraIzBRzwrxaCTNiD+8we+KJk0dn/yI9KJteJ6UyJfWu/suBuwEQTKDeW
         C7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661226; x=1783266026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DO0OX+dpZ5HpX7s3jWDeFyKGT1OqtjfvNdjF+pWZd2U=;
        b=fuMeu1waunLqh+YZi4FhBjllwfCSDzinZYqlMPudBqgeh5lgqE3YU6n/DHHs6gTHZr
         xkrdgZZ9fXnmMOakaOn7FstWWewrbV9abj8S9iubu5qhfPhPQk6I21l00qZouSc3oZcd
         doXU9uT0a2wrIvCWEo6Amlco6GHUwJFoxXJU2jIKHm6SOA8ib0/5NTDV0rmWsGW1poiT
         F5NmjoaVTjr5MnSaHoXR84MWLACU6uDCsBzwrumLA7O6OiMez6JyMalQKKy/umXCpYHF
         kEs+F6TRbHZF0Kg1z/7jKMdZDmFT3IcfcASl0w3O3lmBI0QIaxaq99pc3ikpC9XzSGVa
         Wv2w==
X-Gm-Message-State: AOJu0YyD3EueRVVHkn0vo+RDRsUv7pva2zqTVeYM+nDrgjKkF8DCqBAZ
	XEO3HeD1oDQ4ggxgbLJX0j5RQ8qLnZeb0TBIMXETN70qpFsa4JHjihSAHsOo1g==
X-Gm-Gg: AfdE7cnP+th97YZZIDBiTm7gom3a1z7ttsTSJCwOubrLdxjl7+w87ao7jEhlHY8Sprv
	aAwejTXi+SS+fZh/4mzYKnbCqpm1g2BO7dGzghU32NHt6aXUaTGlgbctjBG5jRj+QP8WAh5QQvV
	eR1BwSmvQYnYjdGwUZE1h+GS1/jMzKDoCibi9BXvdKGrnw+6c6pK3XrxfdmA0jYRjAhDDa/Q4H2
	b7wcejNThYKxU58QLxC07Z/DdkI6ZHNO4vWDRQWR/qvVyHQWkaA89uGJcPDlQmLWpMFHZc/R36Y
	ESZ7M/JrA23VqGGyqAkDiCxVvrtfYcSOdn6g7NNGVvdsCZwBnPvkkU6UqlcfXyPZlQ1XqRhmnCX
	cH1tkvyvAKjhpPR/uF4nr8dTthHQPdwXSOmT4zDUwvRXkyFIR+RVEoNrHY4sLksEgSy17btMf3N
	pob/ut+mUSXG7JPDA=
X-Received: by 2002:a05:600c:a209:b0:492:40df:d49c with SMTP id 5b1f17b1804b1-4926fc770bemr97099995e9.23.1782661225617;
        Sun, 28 Jun 2026 08:40:25 -0700 (PDT)
Received: from localhost ([213.55.168.64])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49268fc0d36sm385531365e9.2.2026.06.28.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 08:40:24 -0700 (PDT)
From: Hannes Diethelm <hannes.diethelm@gmail.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: Hannes Diethelm <hannes.diethelm@gmail.com>
Subject: [PATCH 1/1] tidbits: net-ping: add ping tidbit using raw socket
Date: Sun, 28 Jun 2026 17:39:56 +0200
Message-ID: <20260628153956.1435330-2-hannes.diethelm@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
References: <20260628153956.1435330-1-hannes.diethelm@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tidbit allows to ping any host and measure the response time.

Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
---
 tidbits/meson.build    |   6 +
 tidbits/oob-net-ping.c | 480 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 486 insertions(+)
 create mode 100644 tidbits/oob-net-ping.c

diff --git a/tidbits/meson.build b/tidbits/meson.build
index 3713219..f24502f 100644
--- a/tidbits/meson.build
+++ b/tidbits/meson.build
@@ -6,6 +6,12 @@ executable('oob-net-icmp',
     dependencies: libevl_dep
 )
 
+executable('oob-net-ping',
+    'oob-net-ping.c',
+    install: true,
+    dependencies: libevl_dep
+)
+
 executable('oob-net-udp',
     'oob-net-udp.c',
     install: true,
diff --git a/tidbits/oob-net-ping.c b/tidbits/oob-net-ping.c
new file mode 100644
index 0000000..efbe11e
--- /dev/null
+++ b/tidbits/oob-net-ping.c
@@ -0,0 +1,480 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * This tidbit demonstrates out-of-band networking, by sending
+ * ICMPv4(ECHO) requests using the raw packet socket
+ * interface. Responses are received and checked.
+ * See https://v4.xenomai.org/core/net/ for details.
+ *
+ * Copyright (C) 2026 Hannes Diethelm <hannes.diethelm@gmail.com>
+ * based on oob-net-icmp.c
+ *
+ */
+
+#include <pthread.h>
+#include <error.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <memory.h>
+#include <getopt.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <linux/if_packet.h>
+#include <netinet/ether.h>
+#include <netinet/ip_icmp.h>
+#include <net/ethernet.h>
+#include <net/if.h>
+#include <arpa/inet.h>
+#include <evl/thread.h>
+#include <evl/clock.h>
+#include <evl/proxy.h>
+#include <evl/net/net.h>
+
+static int verbosity = 1;
+
+static uint16_t ip_checksum(void *buf, int len)
+{
+	uint16_t *p = buf;	/* buf is assumed to be 16bit-aligned. */
+	uint32_t sum = 0;
+	int count = len;
+
+	while (count > 1) {
+		sum += *p++;
+		count -= sizeof(*p);
+	}
+
+	if (count > 0)
+		sum += *(uint8_t *)p;
+
+	while (sum >> 16)
+		sum = (sum & 0xffff) + (sum >> 16);
+
+	return ~sum & 0xffff;
+}
+
+static void dump_packet(const char *title, const unsigned char *buf, int len)
+{
+	int n = 0;
+
+	evl_printf("== dumping %s, length=%d\n", title, len);
+
+	while (len-- > 0) {
+		evl_printf("%.2x ", *buf++);
+		if ((++n % 16) == 0)
+			evl_printf("\n");
+	}
+
+	if (n % 16)
+		evl_printf("\n");
+}
+
+static void print_ip_header(const struct ip *iphdr)
+{
+	evl_printf("iphdr.ip_hl=%d\n", iphdr->ip_hl);
+	evl_printf("iphdr.ip_v=%d\n", iphdr->ip_v);
+	evl_printf("iphdr.ip_len=%d\n", ntohs(iphdr->ip_len));
+	evl_printf("iphdr.ip_id=%d\n", ntohs(iphdr->ip_id));
+	evl_printf("iphdr.ip_p=%d\n", iphdr->ip_p);
+	evl_printf("iphdr.ip_sum=%#x\n", iphdr->ip_sum);
+}
+
+static void print_icmp_reply(const void *etherbuf, size_t len)
+{
+	const struct icmphdr *icmphdr;
+	const struct ip *iphdr; /* no option behind */
+	const void *icmpdata;
+
+	dump_packet("ICMP reply", etherbuf, len);
+	iphdr = etherbuf + ETH_HLEN;
+	print_ip_header(iphdr);
+	icmphdr = (const struct icmphdr *)(iphdr + 1);
+	icmpdata = icmphdr + 1;
+	(void)icmpdata;
+	evl_printf("icmp.icmp_type=%d\n", icmphdr->type);
+	evl_printf("icmp.icmp_id=%d\n", ntohs(icmphdr->un.echo.id));
+	evl_printf("icmp.icmp_seq=%d\n", ntohs(icmphdr->un.echo.sequence));
+}
+
+static int check_icmp_reply(void *etherbuf, size_t len, uint16_t id, uint16_t sequence)
+{
+	struct ip *iphdr;
+	struct icmphdr *icmphdr;
+
+	if (len < ETH_HLEN + sizeof(struct ip) + sizeof(struct icmphdr)) {
+		if (verbosity > 1)
+			dump_packet("truncated packet", etherbuf, len);
+		return 1;
+	}
+
+	size_t datalen = len - ETH_HLEN - sizeof(struct ip) - sizeof(struct icmphdr);
+
+	iphdr = etherbuf + ETH_HLEN;
+	icmphdr = (struct icmphdr *)(iphdr + 1);
+
+	if (iphdr->ip_hl != 5 || iphdr->ip_v != 4 || iphdr->ip_p != IPPROTO_ICMP) {
+		if (verbosity > 1) {
+			dump_packet("mangled packet", etherbuf, len);
+			print_ip_header(iphdr);
+		}
+		return 1;
+	}
+
+	/* IP checksum */
+	uint16_t ip_cksum = ip_checksum(iphdr, sizeof(*iphdr));
+	if (ip_cksum != 0) {
+		evl_printf("ip checksum error\n");
+		return 1;
+	}
+
+	/* ICMP checksum */
+	uint16_t icmp_cksum = ip_checksum(icmphdr, sizeof(*icmphdr) + datalen);
+	if (icmp_cksum != 0) {
+		evl_printf("icmp checksum error\n");
+		return 1;
+	}
+
+	if (ntohs(icmphdr->un.echo.id) != id) {
+		evl_printf("id mismatch\n");
+		return 1;
+	}
+	if (ntohs(icmphdr->un.echo.sequence) != sequence) {
+		evl_printf("sequence mismatch\n");
+		return 1;
+	}
+
+	if (verbosity > 1)
+		print_icmp_reply(etherbuf, len);
+
+	return 0;
+}
+
+static size_t build_icmp_request(uint8_t *o_frame, size_t icmplen,
+				 const struct in_addr *dst_ip,
+				 const struct in_addr *src_ip,
+				 const struct ether_addr *dst_mac,
+				 const struct ether_addr *src_mac,
+				 uint16_t id,
+				 uint16_t sequence)
+{
+	struct icmphdr *icmphdr;
+	struct ip *iphdr;
+	uint16_t cksum;
+	size_t datalen;
+	size_t pktlen;
+	uint8_t *data;
+
+	pktlen = icmplen + ETH_HLEN + sizeof(*iphdr);
+	memset(o_frame, 0, pktlen);
+
+	iphdr = (struct ip *)(o_frame + ETH_HLEN);
+	icmphdr = (struct icmphdr *)(iphdr + 1);
+	data = (uint8_t *)(icmphdr + 1);
+	if (icmplen < sizeof(*icmphdr)) {
+		evl_printf("icmplen to short\n");
+		return 0;
+	}
+	datalen = icmplen - sizeof(*icmphdr);
+
+	/* MAC */
+	memcpy(o_frame, dst_mac, ETH_ALEN);
+	memcpy(o_frame + ETH_ALEN, src_mac, ETH_ALEN);
+	o_frame[ETH_HLEN - 2] = (ETH_P_IP >> 8) & 0xff;
+	o_frame[ETH_HLEN - 1] = ETH_P_IP & 0xff;
+
+	/* IPv4 */
+	iphdr->ip_hl = 5;
+	iphdr->ip_v = 4;
+	iphdr->ip_tos = 0;
+	iphdr->ip_len = htons(pktlen - ETH_HLEN);
+	iphdr->ip_id = htons(sequence + id + 0x1000);
+	iphdr->ip_off = htons(IP_DF);
+	iphdr->ip_ttl = 64;
+	iphdr->ip_p = IPPROTO_ICMP;
+	memcpy(&iphdr->ip_src, src_ip, sizeof(iphdr->ip_src));
+	memcpy(&iphdr->ip_dst, dst_ip, sizeof(iphdr->ip_dst));
+	iphdr->ip_sum = 0;
+	iphdr->ip_sum = ip_checksum(iphdr, sizeof(*iphdr));
+
+	/* ICMP */
+	icmphdr->type = ICMP_ECHO;
+	icmphdr->code = 0;
+	icmphdr->un.echo.id = htons(id);
+	icmphdr->un.echo.sequence = htons(sequence);
+	icmphdr->checksum = 0;
+
+	/* data */
+	for (size_t i = 0; i < datalen; i++)
+		data[i] = i + '0';
+
+	/* ICMP checksum */
+	cksum = ip_checksum(icmphdr, sizeof(*icmphdr) + datalen);
+	icmphdr->checksum = cksum;
+
+	if (verbosity > 1) {
+		evl_printf("ip_len=%zd, icmp_len=%zd, ip_len=%d, datalen=%ld\n",
+			   sizeof(*iphdr), sizeof(struct icmphdr),
+			   ntohs(iphdr->ip_len), datalen);
+		print_ip_header(iphdr);
+		dump_packet("ICMP request", o_frame, pktlen);
+	}
+
+	return pktlen;
+}
+
+static void usage(void)
+{
+	fprintf(stderr, "oob-net-ping -i <network-interface> -a <addr> [-d][-s]\n");
+}
+
+int main(int argc, char *argv[])
+{
+	uint8_t i_frame[ETHER_MAX_LEN], o_frame[ETHER_MAX_LEN];
+	int ret, tfd, s, c, ifindex;
+	const char *netif = NULL;
+	const char *ip_addr = NULL;
+	struct oob_msghdr msghdr;
+	struct sched_param param;
+	struct sockaddr_ll addr;
+	struct sockaddr_in dst_addr, src_addr;
+	struct sockaddr dst_hwaddr, src_hwaddr;
+	struct arpreq arp_request;
+	struct ifreq ifr;
+	struct iovec iov;
+	struct timespec ts_timeout;
+	struct timespec ts_ping_tx;
+	struct timespec ts_ping_rx;
+	uint16_t id = getpid(); //Use pid as ID randomization
+	uint16_t sequence = 0;
+	ssize_t count;
+	useconds_t delay=1000000;
+
+	while ((c = getopt(argc, argv, "i:a:w:ds")) != EOF) {
+		switch (c) {
+		case 'i':
+			netif = optarg;
+			break;
+		case 'a':
+			ip_addr = optarg;
+			break;
+		case 'w':
+			delay = atoi(optarg);
+			break;
+		case 'd':
+			verbosity = 2;
+			break;
+		case 's':
+			verbosity = 0;
+			break;
+		default:
+			usage();
+			exit(1);
+		}
+	}
+
+	dst_addr.sin_family = AF_INET;
+	dst_addr.sin_port = htons(0);
+	if (!inet_pton(AF_INET, ip_addr, &dst_addr.sin_addr))
+		error(1, EINVAL, "invalid IP address");
+
+	if (netif == NULL || ip_addr == NULL) {
+		usage();
+		exit(2);
+	}
+
+	param.sched_priority = 1;
+	ret = pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
+	if (ret)
+		error(1, ret, "pthread_setschedparam()");
+
+	tfd = evl_attach_self("oob-net-icmp:%d", getpid());
+	if (tfd < 0)
+		error(1, -tfd, "cannot attach to the EVL core");
+
+	/*
+	 * Get a UDP socket with out-of-band capabilities for solicit.
+	 * Solicit does not work with raw socket (It can not, raw captures all)
+	 */
+	s = socket(AF_INET, SOCK_DGRAM | SOCK_OOB, 0);
+	if (s < 0)
+		error(1, errno, "cannot create drgram packet socket");
+
+	if (netif) {
+		if (setsockopt(s, SOL_SOCKET, SO_BINDTODEVICE, netif, strlen(netif)))
+			error(1, errno, "setsockopt(SO_BINDTODEVICE)");
+		if (verbosity)
+			printf("== bound to %s\n", netif);
+	}
+	/*
+	* Guarantee a mere oob path from the first packet
+	* onward by pre-caching the route and link-layer
+	* address via an explicit neighbour solicitation
+	* before we start sending data.
+	*/
+	ret = evl_net_solicit(s, (const struct sockaddr *)&dst_addr,
+			      EVL_NEIGH_PERMANENT);
+	if (ret)
+		error(1, -ret, "evl_net_solicit()");
+
+	close(s);
+
+	/*
+	 * Get a raw socket with out-of-band capabilities.
+	 */
+	s = socket(AF_PACKET, SOCK_RAW | SOCK_OOB, 0);
+	if (s < 0)
+		error(1, errno, "cannot create raw packet socket");
+
+	/*
+	 * Get ifindex
+	 */
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, netif, IFNAMSIZ - 1);
+	ret = ioctl(s, SIOCGIFINDEX, &ifr);
+	if (ret < 0)
+		error(1, errno, "ioctl(SIOCGIFINDEX)");
+
+	ifindex = ifr.ifr_ifindex;
+
+	/*
+	 * Get local mac address
+	 */
+	ret = ioctl(s, SIOCGIFHWADDR, &ifr);
+	if (ret < 0)
+		error(1, errno, "ioctl(SIOCGIFHWADDR)");
+
+	src_hwaddr = ifr.ifr_hwaddr;
+
+	/*
+	 * Get the local ip address
+	 */
+	ret = ioctl(s, SIOCGIFADDR, &ifr);
+	if (ret < 0)
+		error(1, errno, "ioctl(SIOCGIFADDR)");
+
+	src_addr.sin_family = AF_INET;
+	src_addr.sin_port = htons(0);
+	src_addr.sin_addr.s_addr = ((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr.s_addr;
+
+	/*
+	 * Get the destination mac address
+	 */
+	memset(&arp_request, 0, sizeof(arp_request));
+	((struct sockaddr_in *)&arp_request.arp_pa)->sin_family = AF_INET;
+	((struct sockaddr_in *)&arp_request.arp_pa)->sin_addr.s_addr = dst_addr.sin_addr.s_addr;
+	memcpy(arp_request.arp_dev, ifr.ifr_name, sizeof(arp_request.arp_dev));
+
+	ret = ioctl(s, SIOCGARP, &arp_request);
+	if (ret < 0)
+		error(1, errno, "ioctl(SIOCGARP)");
+
+	if (arp_request.arp_flags & ATF_COM) {
+		dst_hwaddr = arp_request.arp_ha;
+	} else {
+		error(1, 0, "ARP entry is incomplete or invalid.\n");
+	}
+
+	if (verbosity > 1) {
+		evl_printf("sending via %s (if%d), ip=%s, mac=%.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
+			ifr.ifr_name, ifindex, inet_ntoa(src_addr.sin_addr),
+			(uint8_t)src_hwaddr.sa_data[0],
+			(uint8_t)src_hwaddr.sa_data[1],
+			(uint8_t)src_hwaddr.sa_data[2],
+			(uint8_t)src_hwaddr.sa_data[3],
+			(uint8_t)src_hwaddr.sa_data[4],
+			(uint8_t)src_hwaddr.sa_data[5]);
+		evl_printf("sending to ip=%s, mac=%.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
+			inet_ntoa(dst_addr.sin_addr),
+			(uint8_t)dst_hwaddr.sa_data[0],
+			(uint8_t)dst_hwaddr.sa_data[1],
+			(uint8_t)dst_hwaddr.sa_data[2],
+			(uint8_t)dst_hwaddr.sa_data[3],
+			(uint8_t)dst_hwaddr.sa_data[4],
+			(uint8_t)dst_hwaddr.sa_data[5]);
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sll_ifindex = ifindex;
+	addr.sll_family = AF_PACKET;
+	addr.sll_protocol = htons(ETH_P_ALL);
+	ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	if (ret)
+		error(1, errno, "cannot bind packet socket");
+
+	if (verbosity)
+		evl_printf("listening to interface %s\n", netif);
+
+	for (;;) {
+		count = build_icmp_request(o_frame, 64,
+			(struct in_addr *)&dst_addr.sin_addr.s_addr,
+			(struct in_addr *)&src_addr.sin_addr.s_addr,
+			(struct ether_addr *)dst_hwaddr.sa_data,
+			(struct ether_addr *)src_hwaddr.sa_data,
+			id, sequence);
+
+		iov.iov_base = o_frame;
+		iov.iov_len = count;
+		msghdr.msg_iov = &iov;
+		msghdr.msg_iovlen = 1;
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+		msghdr.msg_name = NULL;
+		msghdr.msg_namelen = 0;
+		msghdr.msg_flags = 0;
+		if (verbosity > 1)
+			evl_printf("  .. ICMP request sent: %zd\n", count);
+
+		evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_ping_tx);
+		count = oob_sendmsg(s, &msghdr, NULL, 0);
+		if (count < 0)
+			error(1, errno, "oob_sendmsg() failed");
+
+		iov.iov_base = i_frame;
+		iov.iov_len = sizeof(i_frame);
+		msghdr.msg_name = &addr;
+		msghdr.msg_namelen = sizeof(addr);
+
+	rx:
+		evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_timeout);
+		ts_timeout.tv_sec += 1;
+		count = oob_recvmsg(s, &msghdr, &ts_timeout, 0);
+		evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_ping_rx);
+		if (count < 0) {
+			if (errno != ETIMEDOUT) {
+				error(1, errno, "oob_recvmsg() failed");
+			} else {
+				evl_printf("  .. ICMP timeout!\n");
+				goto next;
+			}
+		}
+
+		if (check_icmp_reply(i_frame, count, id, sequence) != 0) {
+			evl_printf("icmp check failed, probably intercepted other package, retry rx\n");
+			goto rx;
+		}
+
+		if (verbosity > 1)
+			evl_printf("  .. ICMP reply recv: %zd\n", count);
+		if (verbosity)
+			evl_printf("[%d] count=%zd, proto=%#hx, ifindex=%d, type=%u, halen=%u, "
+				"mac=%.2x:%.2x:%.2x:%.2x:%.2x:%.2x rtt=%.1fus\n",
+				sequence, count, ntohs(addr.sll_protocol),
+				addr.sll_ifindex, addr.sll_pkttype,
+				addr.sll_halen, (uint8_t)addr.sll_addr[0],
+				(uint8_t)addr.sll_addr[1],
+				(uint8_t)addr.sll_addr[2],
+				(uint8_t)addr.sll_addr[3],
+				(uint8_t)addr.sll_addr[4],
+				(uint8_t)addr.sll_addr[5],
+				(ts_ping_rx.tv_sec - ts_ping_tx.tv_sec) * 1000000.0 +
+				(ts_ping_rx.tv_nsec - ts_ping_tx.tv_nsec) / 1000.0);
+next:
+		evl_usleep(delay);
+		sequence++;
+	}
+
+	return 0;
+}
-- 
2.47.3

